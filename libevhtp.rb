require "formula"

class Libevhtp < Formula
  homepage "https://github.com/ellzey/libevhtp"
  url "https://github.com/ellzey/libevhtp/archive/1.2.9.tar.gz"
  sha1 "c4edfcfd1427db26e585ee7bc9bce7df4f10ec3d"

  head "https://github.com/ellzey/libevhtp.git"

  option 'with-brewed-openssl', "Build with Homebrew OpenSSL"

  depends_on 'cmake' => :build
  depends_on 'libevent'
  depends_on 'openssl' if build.with? 'brewed-openssl'

  def install
    system "cmake", ".", "-DEVHTP_BUILD_SHARED=on", *std_cmake_args
    system "make"
    system "make", "install"
  end
end
