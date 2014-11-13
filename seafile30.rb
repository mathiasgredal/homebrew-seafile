require "formula"

class Seafile30 < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile/archive/v3.0.5-testing.tar.gz"
  sha1 "24a1d1a0beb88e00b6a8c207b1bf93ef39fc3c82"
  version "3.0.5"

  head "https://github.com/haiwen/seafile.git"

  stable do
    #Use uname command to detect Darwin platform
    patch :p1 do
      url "https://github.com/Chilledheart/seafile/commit/f37dad80.diff"
      sha1 "32c21eae697bf73e31efaaf9805f907d89838aab"
    end

    #[FIX] Add -liconv for homebrew build
    patch :p1 do
      url "https://github.com/Chilledheart/seafile/commit/792f55c5.diff"
      sha1 "9228f124342b7c2e86801b8b33c60cf3a3bab827"
    end
  end
  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/seafile/commit/5848eb75.diff"
    sha1 "b8b0d17ae03474e996ce7e2a42aefe0edb80d159"
  end

  option 'without-brewed-openssl', "Build without Homebrew OpenSSL"
  option 'with-brewed-sqlite', 'Build with Homebrew sqlite3'

  depends_on 'autoconf' => :build
  depends_on "automake" => :build
  depends_on 'pkg-config' => :build
  depends_on 'libtool' => :build
  depends_on 'vala' => :build
  depends_on 'glib'
  depends_on 'ossp-uuid'
  depends_on 'jansson'
  depends_on 'libzdb'
  depends_on 'libevent'
  depends_on 'zlib'
  depends_on 'sqlite' if build.with? 'brewed-sqlite'

  #Compatiblity issue with Apple's Secure Transport
  depends_on 'openssl' if build.with? 'brewed-openssl'

  depends_on 'libsearpc30'
  depends_on 'ccnet30'

  def install

    args = %W[
      --prefix=#{prefix}
      --enable-client
      --disable-server
    ]

    ENV.j1
    system "./autogen.sh"
    system "./configure", *args
    system "python `which searpc-codegen.py` ./lib/rpc_table.py"
    system "make"
    system "make", "install"
  end
end
