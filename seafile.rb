require "formula"

class Seafile < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile/archive/v4.0.1.tar.gz"
  sha256 "99356768e5edd2a81d27e171f2d16cca068e170bf97c2477e6991e60254dddbb"
  version "4.0.1"

  head "https://github.com/haiwen/seafile.git"

  #[FIX] fix openssl build
  patch :p1 do
    url "https://github.com/haiwen/seafile/commit/79fc942d.diff"
    sha256 "58a174473668972bb2a56dde434aa9a70c1c37c122b469a2a1ba9f0efbddeeec"
  end

  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/haiwen/seafile/commit/5848eb75.diff"
    sha256 "98d15cc9bd2c402a4017252adce95e4b55ef10d0006fea6e50c0f40cb1dbc31d"
  end

  #[FIX] use system zlib
  patch :p1 do
    url "https://github.com/haiwen/seafile/commit/239c148b.diff"
    sha256 "ff0e5912be540d4c68e4edf2b50979e45898beb1eb1fe5ed1134b6b675e77447"
  end

  #depends_on MinimumMacOSRequirement => :lion

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

  if MacOS.version >= :mountain_lion
    depends_on "curl" => "openssl"
  else
    depends_on "curl"
  end

  depends_on "SimonGr3dal/libsearpc"
  depends_on "SimonGr3dal/ccnet"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-client
      --disable-server
      --disable-fuse
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
