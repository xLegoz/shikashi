=begin

Authors:

	Scott Ellard 	(scott.ellard@gmail.com)

This file is part of the shikashi project, http://github.com/tario/shikashi

Copyright (c) 2009-2010 Roberto Dario Seminara <robertodarioseminara@gmail.com>

shikashi is free software: you can redistribute it and/or modify
it under the terms of the gnu general public license as published by
the free software foundation, either version 3 of the license, or
(at your option) any later version.

shikashi is distributed in the hope that it will be useful,
but without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.  see the
gnu general public license for more details.

you should have received a copy of the gnu general public license
along with shikashi.  if not, see <http://www.gnu.org/licenses/>.

=end
require "test/unit"
require "rubygems"
require "shikashi"

class SystemCalls < Test::Unit::TestCase
  
  def test_backtick_call_should_raise_error
    priv = Shikashi::Privileges.new
    assert_raise SecurityError do
      Shikashi::Sandbox.new.run("`ls`", priv)
    end
  end
  
  def test_percent_x_call_should_raise_error
    priv = Shikashi::Privileges.new
    assert_raise SecurityError do
      Shikashi::Sandbox.new.run("%x[ls]", priv)
    end
  end
  
  def test_system_call_should_raise_error
    priv = Shikashi::Privileges.new
    assert_raise SecurityError do
      Shikashi::Sandbox.new.run("system('ls')", priv)
    end
  end
  
  def test_exec_call_should_raise_error
    priv = Shikashi::Privileges.new
    assert_raise SecurityError do
      Shikashi::Sandbox.new.run("exec('ls')", priv)
    end
  end

end