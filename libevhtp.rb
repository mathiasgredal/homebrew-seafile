require "formula"

class Libevhtp < Formula
  homepage "http://www.seafile.com/"
  stable do
    url "https://github.com/ellzey/libevhtp/archive/1.2.9.tar.gz"
    sha1 "c4edfcfd1427db26e585ee7bc9bce7df4f10ec3d"
  end
  head do
    url "https://github.com/ellzey/libevhtp.git"
  end

  depends_on 'cmake' => :build
  depends_on 'libevent'

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end
end
