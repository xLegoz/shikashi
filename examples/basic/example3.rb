# call method defined in sandbox from outside

require "rubygems"
require "shikashi"

include Shikashi

s = Sandbox.new
priv = Privileges.new

# allow execution of foo in this object
priv.object(self).allow :foo

# allow execution of print
priv.allow_method :print

# allow execution of method_added
priv.allow_method :method_added

# allow execution of singleton_method_added
priv.allow_method :singleton_method_added

#inside the sandbox, only can use method foo on main and method times on instances of Fixnum
s.eval_binding = binding
s.run(priv, '
module A
def self.inside_foo(a)
	print "inside_foo\n"
	if (a)
	system("ls -l") # denied
	end
end
end
')

# run privileged code in the sandbox, if not, the methods defined in the sandbox are invisible from outside
s.run do
	A.inside_foo(false)
	begin
	A.inside_foo(true)
	rescue SecurityError => e
		print "A.inside_foo(true) failed due security errors: #{e}\n"
	end
end

