.libPaths("~/Rlibs")
library(argparser)

p <- arg_parser("A brief description of what this Rscript does.")


p <- add_argument(p, "--ncores", type = "integer", default = 1L,
                  help = "Number of CPUs to use for parallel processing")
p <- add_argument(p, "--repl", type = "integer", default = 1L,
                  help = "Number of replications to run")


p <- add_argument(p, "task", type = "integer", 
                  help = "Task number")

args <- parse_args(p)

output_str <- paste("Running code on", args$ncores, "CPUs\n")
output_file <- paste0("results_repl", args$repl, "_task", args$task, ".txt")
output_str <- paste0(output_str, "Results will be saved to file: ", output_file, "\n")


cat(output_str)


writeLines(output_str, con = output_file)
