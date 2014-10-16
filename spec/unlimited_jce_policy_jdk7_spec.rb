describe UnlimitedJcePolicyJdk7::Initializer do
  context 'with only a few things stubbed out' do
    before :each do
      skip('jruby only') unless RUBY_PLATFORM == 'java'
      require 'java'
      allow(java.lang.System).to receive(:properties)
        .and_return('java.home' => java_home)
      allow(subject).to receive(:app_root).and_return(app_root)
      FileUtils.mkdir_p(File.join(java_home, 'lib/security'))
    end

    let(:java_home) { File.join(tmpdir, 'java_home') }
    let(:app_root) { File.join(tmpdir, 'app_root') }
    let(:tmpdir) { Dir.mktmpdir }

    after do
      FileUtils.rm_rf(tmpdir)
    end

    it 'initializes the whole shebang' do
      subject.init
      [
        subject.send(:security_path),
        subject.send(:system_security_path)
      ].each do |basedir|
        expect(File.directory?(basedir)).to eq(true)
        %w(local_policy.jar US_export_policy.jar).each do |jar|
          expect(File.exist?(File.join(basedir, jar))).to eq(true)
        end
      end
    end
  end

  context 'with lots of things stubbed out' do
    before :each do
      allow(subject)
        .to receive_message_chain(:java, :lang, :System, :properties)
        .and_return('java.home' => java_home)
      allow(subject).to receive(:cp)
      allow(subject).to receive(:mkdir_p)
      allow(subject).to receive(:security_path).and_return(security_path)
      allow(subject).to receive(:system_security_path)
        .and_return(system_security_path)
      allow(subject).to receive(:jars).and_return(jars)
    end

    let(:security_path) { 'lib/security/omg' }
    let(:system_security_path) { '/system/lib/security/omg' }
    let(:jars) { %w(whatever.jar else.jar) }
    let(:java_home) { 'some/java/home' }

    it 'makes sure the security path exists' do
      expect(subject).to receive(:mkdir_p).with(security_path)
      subject.init
    end

    it 'makes sure the system security path exists' do
      expect(subject).to receive(:mkdir_p).with(system_security_path)
      subject.init
    end

    it 'copies each jar to the security path dir' do
      jars.each do |jar|
        expect(subject).to receive(:cp)
          .with(jar, File.join(security_path, jar))
      end
      subject.init
    end

    context 'when system_install is false-y' do
      it 'does not mkdir_p the system security path' do
        expect(subject).to_not receive(:mkdir_p)
          .with(subject.send(:system_security_path))
        subject.init(false)
      end
    end
  end
end
