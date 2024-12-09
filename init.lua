require("artem.core")
require("artem.lazy")

--this is required so that NVIM uses new java version as opposed to the 261
vim.fn.setenv("JAVA_HOME", "/usr/local/opt/openjdk")
