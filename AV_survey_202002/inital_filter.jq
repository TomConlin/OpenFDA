{   meta_last_updated: .meta|.last_updated,
    results: [.results|.[]
        |select((.serious_ae != null) and (.animal|.species != null))
        |del(.receiver)
        |del(.drug|.[]|.manufacturer,.brand_name,.lot_number)
    ]
}

# Not getting how to do this;
# I want to delete an (un-named) object from an array, iff it is missing a key
# ...active_ingredients[{name=foo, dose={bar=0}}]  object is kept. has key 'name'
# ...active_ingredients[{dose={bar=0}}] object is deleted because key 'name' is absent
