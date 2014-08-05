require "formula"

class Seafile < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile/archive/v3.0.4-server.tar.gz"
  sha1 "a0a91b2e42e1a17a3b9c83bb3c9a3b96235292b4"
  version "3.0.4"
  revision 2

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
  depends_on 'intltool' => :build
  depends_on 'vala' => :build
  depends_on 'glib'
  depends_on 'ossp-uuid'
  depends_on 'jansson'
  depends_on 'gettext'
  depends_on 'libzdb'
  depends_on 'libevent'
  depends_on 'zlib'
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
    system "python `which searpc-codegen.py` ./lib/rpc_table.py"
    system "make"
    system "make", "install"
  end
end
