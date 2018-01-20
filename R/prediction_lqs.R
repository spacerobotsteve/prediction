#' @rdname prediction
#' @export
prediction.lqs <- 
function(model, 
         data = find_data(model), 
         at = NULL, 
         calculate_se = FALSE,
         ...) {
    
    # extract predicted values
    data <- data
    if (missing(data) || is.null(data)) {
        pred <- make_data_frame(fitted = predict(model, ...), se.fitted = NA_real_)
    } else {
        # setup data
        if (is.null(at)) {
            out <- data
        } else {
            out <- build_datalist(data, at = at, as.data.frame = TRUE)
        }
        # calculate predictions
        tmp <- predict(model, 
                       newdata = out, 
                       ...)
        # cbind back together
        pred <- make_data_frame(out, fitted = tmp, se.fitted = rep(NA_real_, nrow(out)))
    }
    
    # obs-x-(ncol(data)+2) data frame
    structure(pred, 
              class = c("prediction", "data.frame"), 
              row.names = seq_len(nrow(pred)),
              at = if (is.null(at)) at else names(at), 
              model.class = class(model),
              type = NA_character_)
}