# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

describe 'trocla::master', type: 'class' do
  context 'with default params' do
    context 'when os is RedHat' do
      let(:facts) do
        {
          osfamily: 'RedHat'
        }
      end

      it {
        expect(subject).to contain_package('trocla').with(
          name: 'rubygem-trocla',
          ensure: 'installed'
        )
      }

      it { is_expected.to compile.with_all_deps }
    end

    context 'when os is Debian' do
      let(:facts) do
        {
          osfamily: 'Debian'
        }
      end

      it {
        expect(subject).to contain_package('trocla').with(
          ensure: 'installed'
        )
      }

      it { is_expected.to compile.with_all_deps }
    end
  end

  context 'with gem provider' do
    let(:params) do
      {
        provider: 'gem'
      }
    end

    it {
      expect(subject).to contain_package('trocla').with(
        ensure: 'installed',
        provider: 'gem'
      )
    }

    it { is_expected.to compile.with_all_deps }

    context 'when os is RedHat' do
      it {
        expect(subject).to contain_package('trocla').with(
          name: 'trocla',
          ensure: 'installed',
          provider: 'gem'
        )
      }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
