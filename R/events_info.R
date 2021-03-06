#' Searches time ocurrence and other information of specific events
#'
#' @param data event dataframe previously loaded
#' @param events one or more events to search (options: SHOT, GOAL, FREE KICK, CORNER KICK)
#'
#' @return dataframe with searched events and their specific info
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom stringr str_detect
#' @export
#'
events_info <- function(data, events = c("SHOT", "GOAL", "FREE KICK", "CORNER KICK")){

        data <- data %>%
                dplyr::mutate(Event = ifelse(Type == "SHOT" & stringr::str_detect(Subtype, '-GOAL'),
                                                     "GOAL", ifelse(Type == "SET PIECE",  Subtype, Type)))

        data %>%
                dplyr::filter(Event %in% events) %>%
                dplyr::select(c(Team, Type, Subtype, Period,
                                StartTime = "Start Time [s]", EndTime ="End Time [s]",
                                StartFrame = "Start Frame", EndFrame = "End Frame", Event))
                                #"From", "To", x1 = "Start X", y1 = "Start Y", x2 = "End X", y2 = "End Y"))
}
