require "formula"

class Ccnet < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/ccnet/archive/v4.0.0.tar.gz"
  version "4.0.0"
  sha1 "c4a637becc4f84ed51eefe9a83a170f93445a1ea"

  head "https://github.com/haiwen/ccnet.git"

  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/ccnet/commit/48610f08.diff"
    sha1 "af5a53ffb9fca0d4918b9d2ef1afd54959ecf186"
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
  depends_on 'jansson'
  depends_on 'gettext'
  depends_on 'libzdb'
  depends_on 'libevent'
  depends_on 'libsearpc'
  depends_on 'sqlite' if build.with? 'brewed-sqlite'

  #Compatiblity issue with Apple's Secure Transport
  depends_on 'openssl' if build.with? 'brewed-openssl'

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
