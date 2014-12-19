require 'fileutils'

module UnlimitedJcePolicyJdk7
  def self.init(system_install = true, debug = false)
    Initializer.new.init(system_install, debug)
  end

  class Initializer
    EFFECTIVELY_UNLIMITED_LENGTH = 2_147_483_647

    def init(system_install = true, debug = false)
      return if key_size_already_unlimited?(debug)
      install!(system_install)
    end

    private

    include FileUtils

    def install!(system_install = true)
      mkdir_p(security_path)
      mkdir_p(system_security_path) if system_install

      jars.each do |jar|
        dest = File.join(security_path, File.basename(jar))
        cp(jar, dest)

        system_dest = File.join(system_security_path, File.basename(jar))

        cp(jar, system_dest) if system_install
      end
    end

    def jars
      Dir.glob(File.expand_path('../jars/*.jar', __FILE__))
    end

    def security_path
      File.join(app_root, '.jdk-overlay/jre/lib/security')
    end

    def system_security_path
      return File.expand_path('~/.jdk/jre/lib/security') if heroku?

      @system_security_path ||= begin
        java_home = java.lang.System.properties['java.home']
        path = File.join(java_home, 'lib/security')
        FileUtils.touch(File.join(path, '.write-test'))
        path
      rescue => e
        warn e
        File.expand_path('~/.jdk/jre/lib/security')
      end
    end

    def app_root
      return ENV['HOME'] if heroku?
      Dir.pwd
    end

    def key_size_already_unlimited?(debug = false)
      %w(AES DES RC2 RSA).all? do |cipher|
        Java::JavaxCrypto::Cipher.get_max_allowed_key_length(cipher) >=
          EFFECTIVELY_UNLIMITED_LENGTH
      end
    rescue => e
      warn e if debug
      false
    end

    def heroku?
      ENV.key?('DYNO')
    end
  end
end
