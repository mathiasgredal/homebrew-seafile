require "formula"

class SeafileClient < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v3.0.4-mac.tar.gz"
  sha1 "6e143d8d86e78b4e1b054bf697a915bf567cfc41"
  version "3.0.4"

  head "https://github.com/haiwen/seafile-client.git"

  option 'without-brewed-openssl', "Build without Homebrew OpenSSL"
  option 'with-brewed-sqlite', 'Build with Homebrew sqlite3'

  depends_on 'cmake' => :build
  depends_on 'jansson'
  depends_on 'qt4'
  depends_on 'sqlite' if build.with? 'brewed-sqlite'

  depends_on 'libsearpc'
  depends_on 'ccnet' => 'with-client'
  depends_on 'seafile' => 'with-client'

  #Compatiblity issue with Apple's Secure Transport
  depends_on 'openssl' if build.with? 'brewed-openssl'

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end
end
