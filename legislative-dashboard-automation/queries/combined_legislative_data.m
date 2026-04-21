let
    // Replace with your folder path when using locally
    Source = Folder.Files("PATH_TO_YOUR_DATA_FOLDER"),

    #"Filtered Hidden Files" = Table.SelectRows(Source, each [Attributes]?[Hidden]? <> true),

    #"Transform Files" = Table.AddColumn(#"Filtered Hidden Files", "Transform File", each #"Transform File"([Content])),

    #"Select Relevant Columns" = Table.SelectColumns(#"Transform Files",{"Date modified", "Transform File"}),

    #"Rename Columns" = Table.RenameColumns(#"Select Relevant Columns",{{"Date modified", "Snapshot_Date"}}),

    #"Expand Data" = Table.ExpandTableColumn(
        #"Rename Columns",
        "Transform File",
        Table.ColumnNames(#"Transform File"(#"Sample File"))
    ),

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

    #"Rename Bill Column" = Table.RenameColumns(#"Change Types",{{"Bill", "Bill_ID"}}),

    // Split Lists into rows
    #"List Category" = Table.AddColumn(#"Rename Bill Column", "List_Category", each 
        let
            CleanText = if [Lists] = null then "Uncategorized" else Text.Trim([Lists]),
            Result = if Text.Contains(CleanText, "#(lf)") then Text.Split(CleanText, "#(lf)") else {CleanText}
        in Result
    ),
    #"Expand List Category" = Table.ExpandListColumn(#"List Category", "List_Category"),

    // Split Subjects into rows
    #"Subject Category" = Table.AddColumn(#"Expand List Category", "Subject_Category", each 
        Text.Split(Text.Trim(if [Subjects] = null then "Uncategorized" else [Subjects]), "#(lf)")
    ),
    #"Expand Subject Category" = Table.ExpandListColumn(#"Subject Category", "Subject_Category"),

    // Split Position into rows
    #"Position Category" = Table.AddColumn(#"Expand Subject Category", "Position_Category", each 
        Text.Split(Text.Trim(if [Position] = null then "Uncategorized" else [Position]), "#(lf)")
    ),
    #"Expand Position Category" = Table.ExpandListColumn(#"Position Category", "Position_Category")

in
    #"Expand Position Category"
