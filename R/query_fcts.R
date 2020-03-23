#' Annotation Queries with ChEMBL IDs
#' Query drug annotations stored in the SQLite database (the defaults are DrugAge,
#' DrugBank, CMAP02, LINCS) with ChEMBL IDs.
#' @param chembl_id character vector of ChEMBL IDs.
#' @param annot character vector of annotation resource, such as DrugAge,
#' DrugBank, CMAP02 or LINCS
#' @return data.frame of annotation result
#' @importFrom RSQLite SQLite
#' @importFrom RSQLite dbConnect
#' @importFrom RSQLite dbSendQuery
#' @importFrom RSQLite dbFetch
#' @importFrom RSQLite dbClearResult
#' @importFrom RSQLite dbDisconnect
#' @examples
#' chembl_id <- c("CHEMBL1064", "CHEMBL10", "CHEMBL113", "CHEMBL1004", "CHEMBL31574")
#' anno_res <- queryCollection(chembl_id, annot=c("DrugAge", "LINCS"))
#'
queryCollection <- function(chembl_id,
                            annot=c("DrugAge", "DrugBank", "CMAP02", "LINCS")){
    chembl_id <- paste0("(\"", paste(chembl_id, collapse="\", \""), "\")")
    dbpath <- system.file("extdata", "compoundCollection.db",
                          package="compoundCollection")
    conn <- dbConnect(SQLite(), dbpath)
    query <- dbSendQuery(conn, paste("SELECT a.chembl_id, a.drugbank_id, a.lincs_id,
            b.species, b.strain, b.dosage, b.avg_lifespan_change,
            b.max_lifespan_change, b.gender, b.significance,
            c.name, c.'cas-number', c.unii, c.state, c.groups, c.'fda-label',
            d.instance_id, d.'concentration..M.', d.'duration..h.', d.cell2, d.array3,
            d.perturbation_scan_id, d.vehicle_scan_id4, d.scanner, d.catalog_number,
            e.pert_iname, e.is_touchstone, e.inchi_key, e.pubchem_cid
		   	FROM id_mapping AS a
			LEFT JOIN drugAgeAnnot AS b ON a.drugage_id = b.drugage_id
			LEFT JOIN DrugBankAnnot AS c ON a.drugbank_id = c.drugbank_id
			LEFT JOIN cmapAnnot AS d ON a.cmap_id = d.cmap_id
			LEFT JOIN lincsAnnot AS e ON a.lincs_id = e.lincs_id
			WHERE a.chembl_id IN", chembl_id,
            "GROUP BY a.chembl_id
            ORDER BY a.chembl_id"))
    assays <- dbFetch(query)
    dbClearResult(query)
    result <- data.frame(assays)
    dbDisconnect(conn)
    return(result)
}
