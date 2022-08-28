# ============================================================================ #
#
# TestR Framework                                                             
# 
# Licensed Under The MIT License
# 
# Copyright (c) 2022 Berkant Yüksektepe
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#   
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# ============================================================================ #


# Config
config.required.msg <- "TestR: Required config name of '%s' is not found in %s/config.yml file."
config.is.null.msg <- "TestR: '%s' is should be not null in %s/config.yml file."

# Test
test.is.null.msg <- "TestR: receiven test data is null, test execution stopped. Please check <test_file_name>.yml files. Default test directory is %s/tests/"
test.tag.title <- "%s (THR: %s, LPS: %s)"
test.start.msg <- "-> TestR: Start by Test Name: %s \n"
test.end.msg <- "-> TestR: End by Test Name: %s \n - \n"

# Replace/Remove
remove.https <- "https://"

# Export
export.pdf.start.msg <- "-> TestR: Start to PDF Export by Test Name: %s \n - \n"
export.pdf.end.msg <- "-> TestR: End PDF Export by Test Name: %s \n - \n"
export.pdf.skip.msg <- "-> TestR: Global export-pdf config: FALSE: PDF Export Skipped by Test Name: %s \n - \n"
