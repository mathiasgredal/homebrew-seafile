require "formula"

class SeafileClient30 < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v3.1.8.tar.gz"
  sha1 "7267326e8566c6590048750abf1ee6529c734812"
  version "3.0.8"

  head "https://github.com/haiwen/seafile-client.git"

  if MacOS.version <= :snow_leopard
    patch :p1 do
      url "https://github.com/Chilledheart/seafile-client/commit/2b96929.diff"
      sha1 "4aa39548be5e62d74841470fa46a273ab3c40eab"
    end
  end

  option 'without-brewed-openssl', "Build without Homebrew OpenSSL"
  option 'with-brewed-sqlite', 'Build with Homebrew sqlite3'
  option "with-xcode", "Build with XCODE_APP Flags"

  depends_on 'cmake' => :build
  depends_on 'glib'
  depends_on 'jansson'
  depends_on 'qt4'
  depends_on 'sqlite' if build.with? 'brewed-sqlite'

  depends_on 'libsearpc30'
  depends_on 'ccnet30'
  depends_on 'seafile30'

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
