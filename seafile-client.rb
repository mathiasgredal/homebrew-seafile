require "formula"

class SeafileClient < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v3.0.4-mac.tar.gz"
  sha1 "6e143d8d86e78b4e1b054bf697a915bf567cfc41"
  version "3.0.4"

  head "https://github.com/haiwen/seafile-client.git"

  option 'without-brewed-openssl', "Build without Homebrew OpenSSL"
  option 'with-brewed-sqlite', 'Build with Homebrew sqlite3'
  option "with-xcode", "Build with XCODE_APP Flags"

  depends_on 'cmake' => :build
  depends_on 'glib'
  depends_on 'jansson'
  depends_on 'qt4'
  depends_on 'sqlite' if build.with? 'brewed-sqlite'

  depends_on 'libsearpc'
  depends_on 'ccnet' => 'with-client'
  depends_on 'seafile' => 'with-client'

  #Compatiblity issue with Apple's Secure Transport
  depends_on 'openssl' if build.with? 'brewed-openssl'

  def install

    cmake_args = std_cmake_args
    if build.with? 'xcode'
      cmake_args << '-DCMAKE_CXX_FLAGS="-DXCODE_APP"'
    end
    system "cmake", ".", *cmake_args
    system "make"
    system "make", "install"
  end
end
