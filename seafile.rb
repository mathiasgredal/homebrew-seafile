require "formula"

class Seafile < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile/archive/v4.0.0.tar.gz"
  sha1 "83d5ca29dd5e8465e6d0ecfbfd5b5145925bb11d"
  version "4.0.0"

  head "https://github.com/haiwen/seafile.git"

  #[FIX] fix openssl build
  patch :p1 do
    url "https://github.com/Chilledheart/seafile/commit/79fc942d.diff"
    sha1 "a4c81dbf6e131502b2c229b9cab2f324e8c51e5d"
  end

  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/seafile/commit/5848eb75.diff"
    sha1 "b8b0d17ae03474e996ce7e2a42aefe0edb80d159"
  end

  depends_on MinimumMacOSRequirement => :lion

  option 'with-brewed-sqlite', 'Build with Homebrew sqlite3'

  depends_on 'autoconf' => :build
  depends_on "automake" => :build
  depends_on 'pkg-config' => :build
  depends_on 'libtool' => :build
  depends_on 'intltool' => :build
  depends_on 'vala' => :build
  depends_on 'glib'
  depends_on 'jansson'
  depends_on 'gettext'
  depends_on 'libzdb'
  depends_on 'libevent'
  depends_on 'zlib'
  depends_on 'curl' => 'openssl'
  depends_on 'openssl'
  depends_on 'sqlite' if build.with? 'brewed-sqlite'
  depends_on 'readline' => :optional

  #Compatiblity issue with Apple's Secure Transport
  depends_on 'openssl' if build.with? 'brewed-openssl'

  depends_on 'libsearpc'
  depends_on 'ccnet'

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
