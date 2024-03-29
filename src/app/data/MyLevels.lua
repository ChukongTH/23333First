
local Levels = {}

Levels.NODE_IS_X1  = 1
Levels.NODE_IS_X1  = 2
Levels.NODE_IS_X1  = 3
Levels.NODE_IS_X1  = 4
Levels.NODE_IS_X1  = 5
--Levels.NODE_IS_EMPTY  = "X"

local levelsData = {}

levelsData[1] = {
    rows = 8,
    cols = 8,
    grid = {
        {1, 2, 3, 4,1, 1, 1, 1},
        {1, 1, 0, 1,1, 1, 1, 1},
        {1, 0, 0, 0,1, 1, 1, 1},
        {1, 1, 1, 1,1, 1, 1, 1},
        {1, 1, 0, 1,1, 1, 1, 1},
        {1, 0, 0, 0,1, 1, 1, 1},
        {1, 0, 0, 0,1, 1, 1, 1},
        {1, 1, 0, 1,1, 1, 1, 1}
    }
}

levelsData[2] = {
    rows = 4,
    cols = 4,
    grid = {
        {1, 0, 1, 1},
        {0, 0, 1, 1},
        {1, 1, 0, 0},
        {1, 1, 0, 1}
    }
}

levelsData[3] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 0, 0, 0},
        {0, 1, 1, 0},
        {0, 1, 1, 0},
        {0, 0, 0, 0}
    }
}

levelsData[4] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 1, 1},
        {1, 0, 0, 1},
        {1, 0, 1, 1},
        {1, 1, 1, 1}
    }
}

levelsData[5] = {
    rows = 4,
    cols = 4,
    grid = {
        {1, 0, 0, 1},
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {1, 0, 0, 1}
    }
}

levelsData[6] = {
    rows = 4,
    cols = 4,
    grid = {
        {1, 0, 0, 1},
        {0, 1, 1, 0},
        {0, 1, 1, 0},
        {1, 0, 0, 1}
    }
}

levelsData[7] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 1, 1},
        {1, 0, 1, 1},
        {1, 1, 0, 1},
        {1, 1, 1, 0}
    }
}

levelsData[8] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 0, 1},
        {1, 0, 0, 0},
        {0, 0, 0, 1},
        {1, 0, 1, 0}
    }
}

levelsData[9] = {
    rows = 4,
    cols = 4,
    grid = {
        {1, 0, 1, 0},
        {1, 0, 1, 0},
        {0, 0, 1, 0},
        {1, 0, 0, 1}
    }
}

levelsData[10] = {
    rows = 4,
    cols = 4,
    grid = {
        {1, 0, 1, 1},
        {1, 1, 0, 0},
        {0, 0, 1, 1},
        {1, 1, 0, 1}
    }
}

levelsData[11] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 1, 0},
        {1, 0, 0, 1},
        {1, 0, 0, 1},
        {0, 1, 1, 0}
    }
}

levelsData[12] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 1, 0},
        {0, 0, 0, 0},
        {1, 1, 1, 1},
        {0, 0, 0, 0}
    }
}

levelsData[13] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 1, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 1, 1, 0}
    }
}

levelsData[14] = {
    rows = 4,
    cols = 4,
    grid = {
        {1, 0, 1, 1},
        {0, 1, 0, 1},
        {1, 0, 1, 0},
        {1, 1, 0, 1}
    }
}

levelsData[15] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 0, 1},
        {1, 0, 0, 0},
        {1, 0, 0, 0},
        {0, 1, 0, 1}
    }
}

levelsData[16] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 1, 0},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {0, 1, 1, 0}
    }
}

levelsData[17] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 1, 1},
        {0, 1, 0, 0},
        {0, 0, 1, 0},
        {1, 1, 1, 0}
    }
}

levelsData[18] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 0, 0, 1},
        {0, 0, 1, 0},
        {0, 1, 0, 0},
        {1, 0, 0, 0}
    }
}

levelsData[19] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 1, 0, 0},
        {0, 1, 1, 0},
        {0, 0, 1, 1},
        {0, 0, 0, 0}
    }
}

levelsData[20] = {
    rows = 4,
    cols = 4,
    grid = {
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0}
    }
}

function Levels.numLevels()
    return #levelsData
end

function Levels.get(levelIndex)
    assert(levelIndex >= 1 and levelIndex <= #levelsData, string.format("levelsData.get() - invalid levelIndex %s", tostring(levelIndex)))
    return clone(levelsData[levelIndex])
end

return Levels
