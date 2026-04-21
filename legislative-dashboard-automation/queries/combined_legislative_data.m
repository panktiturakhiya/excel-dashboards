let
    // Replace with your local folder path when running the query
    Source = Folder.Files("PATH_TO_YOUR_DATA_FOLDER"),

    // Exclude hidden files
    #"Filtered Hidden Files" = Table.SelectRows(Source, each [Attributes]?[Hidden]? <> true),

    // Apply transformation logic to each file
    #"Transform Files" = Table.AddColumn(#"Filtered Hidden Files", "Transform File", each #"Transform File"([Content])),

    // Keep only relevant metadata and transformed output
    #"Select Relevant Columns" = Table.SelectColumns(#"Transform Files", {"Date modified", "Transform File"}),
    #"Rename Columns" = Table.RenameColumns(#"Select Relevant Columns", {{"Date modified", "Snapshot_Date"}}),

    // Expand transformed data
    #"Expand Data" = Table.ExpandTableColumn(
        #"Rename Columns",
        "Transform File",
        Table.ColumnNames(#"Transform File"(#"Sample File"))
    ),

    // Set column types
    #"Change Types" = Table.TransformColumnTypes(#"Expand Data",{
        {"Bill", type text},
        {"Sponsors", type text},
        {"Session", Int64.Type},
        {"State", type text},
        {"Title", type text},
        {"Notes", type text},
        {"Last Action Date", type date},
        {"Last Action Chamber", type text},
        {"Last Action", type text},
        {"Latest Version", type text},
        {"Lists", type text},
        {"Subjects", type text},
        {"Position", type text}
    }),

    // Rename identifier column
    #"Rename Bill Column" = Table.RenameColumns(#"Change Types", {{"Bill", "Bill_ID"}}),

    // Expand multi-value Lists field into rows
    #"Create List Category" = Table.AddColumn(
        #"Rename Bill Column",
        "List_Category",
        each
            let
                CleanText = if [Lists] = null then "Uncategorized" else Text.Trim([Lists]),
                Result = if Text.Contains(CleanText, "#(lf)") then Text.Split(CleanText, "#(lf)") else {CleanText}
            in
                Result
    ),
    #"Expand List Category" = Table.ExpandListColumn(#"Create List Category", "List_Category"),

    // Expand multi-value Subjects field into rows
    #"Create Subject Category" = Table.AddColumn(
        #"Expand List Category",
        "Subject_Category",
        each Text.Split(Text.Trim(if [Subjects] = null then "Uncategorized" else [Subjects]), "#(lf)")
    ),
    #"Expand Subject Category" = Table.ExpandListColumn(#"Create Subject Category", "Subject_Category"),

    // Expand multi-value Position field into rows
    #"Create Position Category" = Table.AddColumn(
        #"Expand Subject Category",
        "Position_Category",
        each Text.Split(Text.Trim(if [Position] = null then "Uncategorized" else [Position]), "#(lf)")
    ),
    #"Expand Position Category" = Table.ExpandListColumn(#"Create Position Category", "Position_Category")

in
    #"Expand Position Category"
