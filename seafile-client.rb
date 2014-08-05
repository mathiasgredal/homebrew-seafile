require "formula"

class SeafileClient < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v3.1.2-testing.tar.gz"
  sha1 "988dcf903232dfb535713f63b02c052fb0a8ea3d"
  version "3.1.2"
  revision 1

  head "https://github.com/haiwen/seafile-client.git"

  patch :p1 do
    url "https://github.com/Chilledheart/seafile-client/commit/0fc2d2c.diff"
    sha1 "1a995b289498da64b985f8cb42d0f08521f238cd"
  end

  patch :p1 do
    url "https://github.com/Chilledheart/seafile-client/commit/6ea9536.diff"
    sha1 "128a0bb383050b595a0148e0ff0f3d821686fbd4"
  end

  option 'without-brewed-openssl', "Build without Homebrew OpenSSL"
  option 'with-brewed-sqlite', 'Build with Homebrew sqlite3'
  option "with-xcode", "Build with XCODE_APP Flags"

  depends_on 'cmake' => :build
  depends_on 'glib'
  depends_on 'jansson'
  depends_on 'qt4'
  depends_on 'sqlite' if build.with? 'brewed-sqlite'

  depends_on 'libsearpc'
  depends_on 'ccnet'
  depends_on 'seafile'

  #Compatiblity issue with Apple's Secure Transport
  depends_on 'openssl' if build.with? 'brewed-openssl'

  def install

    cmake_args = std_cmake_args
    if build.with? 'xcode'
      cmake_args << '-DCMAKE_CXX_FLAGS="-DXCODE_APP"'
    end
    if MacOS.version <= :snow_leopard
      cmake_args << "-DCMAKE_OSX_DEPLOYMENT_TARGET=10.6"
    end
    system "cmake", ".", *cmake_args
    system "make"
    system "make", "install"
  end
end
