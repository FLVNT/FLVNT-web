INDEXES
=======


    db.likes.ensureIndex( { post_id: 1, created_by: 1 }, { unique: true } )

    # TODO do we need a compound index on source,id to ensure uniqueness?
    db.library.ensureIndex( { id: 1 }, { unique: true } )

    # TODO index to help sort posts in reverse chronological order
    db.posts.ensureIndex( { group_id: 1 } )

    # TODO index to help sort comments in reverse chronological order?
    db.comments.ensureIndex( { post_id: 1 } )

