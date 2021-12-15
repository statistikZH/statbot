def map_name_to_number(df, columns_to_map):
    metadata = {}
    for col in columns_to_map:
        conversion_dict = {}
        metadata_col = {}
        options = set(df[col])
        for i, option in enumerate(options):
            conversion_dict[option] = i
            metadata_col[i] = option
        df[col] = df[col].map(conversion_dict)
        metadata[col] = metadata_col
    return df, metadata