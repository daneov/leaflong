workspace {
    model {
        healthSeeker = person "Healthseeker" "A user looking for a specific solution"
        curiousUser = person "Curious user" "A user curious to the world of herbal treatments"
        system = softwareSystem "Leaf long" {
            mobileApp = container "Mobile Application" "Used to interact with and propose treatments" {
                technology "iOS"

                group ViewControllers {
                    overview = component "OverviewViewController" {
                        technology "Swift"
                        description "Display a random list of herbs/ailments for which we have recipes"
                    }

                    search = component "SearchViewController" {
                        technology "Swift"
                        description "Allows the users to search for herbs and treatments"
                    }

                    map = component "HerbScoutViewController" {
                        technology "Swift"
                        description "Display probable location of herbs in a map"
                    }
                }

                group Services {
                    searchService = component "SearchService" {
                        technology "Swift"
                        description "Processes the search and performs the request where needed"

                        search -> this
                        map -> this
                    }
                }
                
            }
            api = container "API" {
                technology "Unknown"

                herbSearch = component "HerbSearchEndpoint" "Return herbs matching the parameters"
                treatmentSearch = component "TreatmentSearchEndpoint" "Return herbs matching the query parameter"
                locationSearch = component "LocationSearchEndpoint" "Return herbs available in the given location"
            }

            cdn = container "CDN" {
                technology "Unknown"
            }

            storage = container "Storage" "Stores images about each herb or remedy" {
                technology "Unknown"
            }

            database = container "Database" "Stores plain data about each herb or remedy" {
                technology "Unknown"
            }

            # User relationships
            curiousUser -> mobileApp "Uses"
            healthseeker -> mobileApp "Uses"

            # Container relationships
            mobileApp -> api "Reads (caches) and submits new herbs & treatments"
            mobileApp -> cdn "Retrieves and displays images"

            api -> database "Reads from and persists data"
            api -> storage "Stores images"
            api -> cdn "Links to images"

            cdn -> storage "Caches images"

            # Component relationships
            searchService -> herbSearch
            searchService -> treatmentSearch
        }
    }

    views {
        systemContext system {
            include *
            autolayout lr
        }

        container system {
            include *
            //autolayout lr
        }

        component mobileApp {
            include *
        }

        component api {
            include *
        }

        styles {
            element "Person" {
              shape Person
            }
        }

        theme default
    }
}
