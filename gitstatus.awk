$1 ~ /#/ {
    if ($2 == "branch.oid") {
    }
    if ($2 == "branch.head") {
        BRANCH = $3
    }
    if ($2 == "branch.upstream") {
    }
    if ($2 == "branch.ab") {
        if ($3 != "+0") {
            AHEAD = $3
        }
        if ($4 != "-0") {
            BEHIND = $4
        }
    }
}
$1 ~ /[1]/ {
    if (match($2, "[MADRC].")) {
        INDEX += 1
    }
    if (match($2, ".[MADRC]")) {
        WORKING += 1
    }
    if (match($2, "[DAU][DAU]")) {
        UNMERGED += 1
    }
}
$1 ~ /[2]/ {
    if (match($2, "[MADRC].")) {
        MOVED += 1
    }
    if (match($2, ".[MADRC]")) {
        MOVED += 1
    }
}
$1 ~ /\?/ {
    UNTRACKED += 1
}
$1 ~ /!/ {
    IGNORED += 1
}
END {
    printf(BRANCH)
    if (AHEAD || BEHIND) {
        printf("(")
        printf(AHEAD)
        if (AHEAD && BEHIND) {
            printf("/")
        }
        printf(BEHIND)
        printf(")")
    }
    if (INDEX) {
        printf("  " INDEX)
    }
    if (WORKING) {
        printf("  " WORKING)
    }
    if (MOVED) {
        printf("  " MOVED)
    }
    if (UNTRACKED) {
        printf("  " UNTRACKED)
    }
}
