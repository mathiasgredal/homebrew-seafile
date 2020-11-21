require "formula"

class Ccnet < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/ccnet/archive/v4.0.1.tar.gz"
  version "4.0.1"
  sha256 "c0688c0214da6f0904fce894ebcc7953b1a783726f4259880d61eb78b208e746"

  head "https://github.com/haiwen/ccnet.git"

  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/haiwen/ccnet/commit/48610f08.diff"
    sha256 "69533104a977346469299dc9224e71c041a48b8783400bbec8a016b819619361"
  end

  #[FIX] openssl build
  patch :p1 do
    url "https://github.com/haiwen/ccnet/commit/4bede362.diff"
    sha256 "dedb1d6f700050680710d6d47cf9b9e4b708b35e0e053167f5b39c89f6ac9adc"
  end

  option "with-brewed-sqlite", "Build with Homebrew sqlite3"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "libtool" => :build
  depends_on "vala" => :build
  depends_on "glib"
  depends_on "jansson"
  depends_on "libzdb"
  depends_on "libevent"
  depends_on "openssl"
  depends_on "sqlite" if build.with? "brewed-sqlite"
  depends_on "libsearpc"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-client
      --disable-server
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
