require_relative '../spec_helper'

describe ReplaceIndirectsWithReferences do
  
it "should replace INDIRECT() functions with the reference that they refer to, if they have been passed a string value" do

input = <<END
A1\t[:function,"INDIRECT", [:string,"$A$5"]]
A2\t[:function,"INDIRECT", [:cell,"$A$5"]]
A3\t[:function, "SUM", [:function, "INDIRECT", [:string, "$A$5:$B$10"]]]
END

expected_output = <<END
A1\t[:cell, "$A$5"]
A2\t[:function, "INDIRECT", [:cell, "$A$5"]]
A3\t[:function, "SUM", [:area, "$A$5", "$B$10"]]
END
    
input = StringIO.new(input)
output = StringIO.new
r = ReplaceIndirectsWithReferences.new
r.replace(input,output)
output.string.should == expected_output

end # / it


end # / describe