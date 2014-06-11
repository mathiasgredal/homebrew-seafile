require "formula"

class Seafile < Formula
  homepage "http://www.seafile.com/"
  stable do
    url "https://github.com/haiwen/seafile/archive/v3.0.4.tar.gz"
    version "3.0.4"
    sha1 "fefddcd96a1905ebd8069314fa4580a8c9064e51"
  end
  head do
    url "https://github.com/haiwen/seafile.git"
  end

  #Silence the annoying "subdir-objects disabled" warning
  patch :p1 do
    url "https://github.com/Chilledheart/seafile/commit/74319f19.diff"
    sha1 "7741f84d3d52750c734e742360fa8a561e23f9ab"
  end
  #Use uname command to detect Darwin platform
  patch :p1 do
    url "https://github.com/Chilledheart/seafile/commit/f37dad80.diff"
    sha1 "32c21eae697bf73e31efaaf9805f907d89838aab"
  end
  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/seafile/commit/5848eb75.diff"
    sha1 "b8b0d17ae03474e996ce7e2a42aefe0edb80d159"
  end


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
  depends_on 'libsearpc'
  depends_on 'ccnet'
  depends_on 'zlib'
  depends_on 'sqlite' => :optional
  depends_on 'readline' => :optional
  depends_on 'libarchive' => :optional

  #Compatiblity issue with Apple's Secure Transport
  depends_on 'openssl'

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--disable-server", "--enable-client"
    system "python `which searpc-codegen.py` ./lib/rpc_table.py"
    system "make"
    system "make", "install"
  end
end
