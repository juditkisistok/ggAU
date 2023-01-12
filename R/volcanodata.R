#' Volcano plot data
#'
#' A dataset containing the results of a differential expression analysis performed using limma-voom.
#' It was created by Maria Doyle for the [Visualization of RNA-Seq results with Volcano Plot](https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/rna-seq-viz-with-volcanoplot/tutorial.html#:~:text=A%20volcano%20plot%20is%20a,the%20most%20biologically%20significant%20genes.) tutorial.
#'
#' @format ## `volcanodata`
#' A data frame with 15,804 rows and 8 columns:
#' \describe{
#'   \item{ENTREZID}{The gene's Entrez ID}
#'   \item{SYMBOL}{Gene symbol}
#'   \item{GENENAME}{Gene name and function}
#'   \item{logFC}{Log fold change, quantifying differential expression}
#'   \item{AveExpr}{Average gene expression}
#'   \item{t}{The t-statistic calculated by limma-voom}
#'   \item{P.value}{The p-value}
#'   \item{adj.P.val}{The adjusted p-value}

#' }
#' @source <https://zenodo.org/record/2529117>
"volcanodata"
