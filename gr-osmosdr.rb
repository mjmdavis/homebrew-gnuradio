require 'formula'

class GrOsmosdr < Formula
  homepage 'http://sdr.osmocom.org/trac/wiki/GrOsmoSDR'
  head 'https://github.com/mjmdavis/gr-osmosdr.git'
  #head 'git://git.osmocom.org/gr-osmosdr'

  depends_on 'cmake' => :build
  depends_on 'gnuradio'
  depends_on 'rtlsdr'

  def install
    mkdir 'build' do
      args =  ["-DPYTHON_LIBRARY=#{python_path}/Frameworks/Python.framework/"] + std_cmake_args 
      system 'cmake', '..', *args
      system 'make VERBOSE=1'
      system 'make install'
    end
  end

  def python_path
    python = Formula.factory('python')
    kegs = python.rack.children.reject { |p| p.basename.to_s == '.DS_Store' }
    kegs.find { |p| Keg.new(p).linked? } || kegs.last
  end
end
