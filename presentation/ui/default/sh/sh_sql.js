if (! this.sh_languages) {
  this.sh_languages = {};
}
sh_languages['sql'] = [
  [
    {
      'regex': /\b(?:[Vv][Aa][Rr][Cc][Hh][Aa][Rr]|[Tt][Ii][Nn][Yy][Ii][Nn][Tt]|[Tt][Ee][Xx][Tt]|[Dd][Aa][Tt][Ee]|[Ss][Mm][Aa][Ll][Ll][Ii][Nn][Tt]|[Mm][Ee][Dd][Ii][Uu][Mm][Ii][Nn][Tt]|[Ii][Nn][Tt]|[Bb][Ii][Gg][Ii][Nn][Tt]|[Ff][Ll][Oo][Aa][Tt]|[Dd][Oo][Uu][Bb][Ll][Ee]|[Dd][Ee][Cc][Ii][Mm][Aa][Ll]|[Dd][Aa][Tt][Ee][Tt][Ii][Mm][Ee]|[Tt][Ii][Mm][Ee][Ss][Tt][Aa][Mm][Pp]|[Tt][Ii][Mm][Ee]|[Yy][Ee][Aa][Rr]|[Uu][Nn][Ss][Ii][Gg][Nn][Ee][Dd]|[Cc][Hh][Aa][Rr]|[Tt][Ii][Nn][Yy][Bb][Ll][Oo][Bb]|[Tt][Ii][Nn][Yy][Tt][Ee][Xx][Tt]|[Bb][Ll][Oo][Bb]|[Mm][Ee][Dd][Ii][Uu][Mm][Bb][Ll][Oo][Bb]|[Mm][Ee][Dd][Ii][Uu][Mm][Tt][Ee][Xx][Tt]|[Ll][Oo][Nn][Gg][Bb][Ll][Oo][Bb]|[Ll][Oo][Nn][Gg][Tt][Ee][Xx][Tt]|[Ee][Nn][Uu][Mm]|[Bb][Oo][Oo][Ll]|[Bb][Ii][Nn][Aa][Rr][Yy]|[Vv][Aa][Rr][Bb][Ii][Nn][Aa][Rr][Yy])\b/g,
      'style': 'sh_type'
    },
    {
      'regex': /\b(?:[Aa][Ll][Ll]|[Aa][Ss][Cc]|[Aa][Ss]|[Aa][Ll][Tt][Ee][Rr]|[Aa][Nn][Dd]|[Aa][Dd][Dd]|[Aa][Uu][Tt][Oo]_[Ii][Nn][Cc][Rr][Ee][Mm][Ee][Nn][Tt]|[Bb][Ee][Tt][Ww][Ee][Ee][Nn]|[Bb][Ii][Nn][Aa][Rr][Yy]|[Bb][Oo][Tt][Hh]|[Bb][Yy]|[Bb][Oo][Oo][Ll][Ee][Aa][Nn]|[Cc][Hh][Aa][Nn][Gg][Ee]|[Cc][Hh][Ee][Cc][Kk]|[Cc][Oo][Ll][Uu][Mm][Nn][Ss]|[Cc][Oo][Ll][Uu][Mm][Nn]|[Cc][Rr][Oo][Ss][Ss]|[Cc][Rr][Ee][Aa][Tt][Ee]|[Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee][Ss]|[Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee]|[Dd][Aa][Tt][Aa]|[Dd][Ee][Ll][Aa][Yy][Ee][Dd]|[Dd][Ee][Ss][Cc][Rr][Ii][Bb][Ee]|[Dd][Ee][Ss][Cc]|[Dd][Ii][Ss][Tt][Ii][Nn][Cc][Tt]|[Dd][Ee][Ll][Ee][Tt][Ee]|[Dd][Rr][Oo][Pp]|[Dd][Ee][Ff][Aa][Uu][Ll][Tt]|[Ee][Nn][Cc][Ll][Oo][Ss][Ee][Dd]|[Ee][Ss][Cc][Aa][Pp][Ee][Dd]|[Ee][Xx][Ii][Ss][Tt][Ss]|[Ee][Xx][Pp][Ll][Aa][Ii][Nn]|[Ff][Ii][Ee][Ll][Dd][Ss]|[Ff][Ii][Ee][Ll][Dd]|[Ff][Ll][Uu][Ss][Hh]|[Ff][Oo][Rr]|[Ff][Oo][Rr][Ee][Ii][Gg][Nn]|[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]|[Ff][Rr][Oo][Mm]|[Gg][Rr][Oo][Uu][Pp]|[Gg][Rr][Aa][Nn][Tt]|[Hh][Aa][Vv][Ii][Nn][Gg]|[Ii][Gg][Nn][Oo][Rr][Ee]|[Ii][Nn][Dd][Ee][Xx]|[Ii][Nn][Ff][Ii][Ll][Ee]|[Ii][Nn][Ss][Ee][Rr][Tt]|[Ii][Nn][Nn][Ee][Rr]|[Ii][Nn][Tt][Oo]|[Ii][Dd][Ee][Nn][Tt][Ii][Ff][Ii][Ee][Dd]|[Ii][Nn]|[Ii][Ss]|[Ii][Ff]|[Jj][Oo][Ii][Nn]|[Kk][Ee][Yy][Ss]|[Kk][Ii][Ll][Ll]|[Kk][Ee][Yy]|[Ll][Ee][Aa][Dd][Ii][Nn][Gg]|[Ll][Ii][Kk][Ee]|[Ll][Ii][Mm][Ii][Tt]|[Ll][Ii][Nn][Ee][Ss]|[Ll][Oo][Aa][Dd]|[Ll][Oo][Cc][Aa][Ll]|[Ll][Oo][Cc][Kk]|[Ll][Oo][Ww]_[Pp][Rr][Ii][Oo][Rr][Ii][Tt][Yy]|[Ll][Ee][Ff][Tt]|[Ll][Aa][Nn][Gg][Uu][Aa][Gg][Ee]|[Mm][Oo][Dd][Ii][Ff][Yy]|[Nn][Aa][Tt][Uu][Rr][Aa][Ll]|[Nn][Oo][Tt]|[Nn][Uu][Ll][Ll]|[Nn][Ee][Xx][Tt][Vv][Aa][Ll]|[Oo][Pp][Tt][Ii][Mm][Ii][Zz][Ee]|[Oo][Pp][Tt][Ii][Oo][Nn]|[Oo][Pp][Tt][Ii][Oo][Nn][Aa][Ll][Ll][Yy]|[Oo][Rr][Dd][Ee][Rr]|[Oo][Uu][Tt][Ff][Ii][Ll][Ee]|[Oo][Rr]|[Oo][Uu][Tt][Ee][Rr]|[Oo][Nn]|[Pp][Rr][Oo][Cc][Ee][Ee][Dd][Uu][Rr][Ee]|[Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Aa][Ll]|[Pp][Rr][Ii][Mm][Aa][Rr][Yy]|[Rr][Ee][Aa][Dd]|[Rr][Ee][Ff][Ee][Rr][Ee][Nn][Cc][Ee][Ss]|[Rr][Ee][Gg][Ee][Xx][Pp]|[Rr][Ee][Nn][Aa][Mm][Ee]|[Rr][Ee][Pp][Ll][Aa][Cc][Ee]|[Rr][Ee][Tt][Uu][Rr][Nn]|[Rr][Ee][Vv][Oo][Kk][Ee]|[Rr][Ll][Ii][Kk][Ee]|[Rr][Ii][Gg][Hh][Tt]|[Ss][Hh][Oo][Ww]|[Ss][Oo][Nn][Aa][Mm][Ee]|[Ss][Tt][Aa][Tt][Uu][Ss]|[Ss][Tt][Rr][Aa][Ii][Gg][Hh][Tt]_[Jj][Oo][Ii][Nn]|[Ss][Ee][Ll][Ee][Cc][Tt]|[Ss][Ee][Tt][Vv][Aa][Ll]|[Ss][Ee][Tt]|[Tt][Aa][Bb][Ll][Ee][Ss]|[Tt][Ee][Mm][Ii][Nn][Aa][Tt][Ee][Dd]|[Tt][Oo]|[Tt][Rr][Aa][Ii][Ll][Ii][Nn][Gg]|[Tt][Rr][Uu][Nn][Cc][Aa][Tt][Ee]|[Tt][Aa][Bb][Ll][Ee]|[Tt][Ee][Mm][Pp][Oo][Rr][Aa][Rr][Yy]|[Tt][Rr][Ii][Gg][Gg][Ee][Rr]|[Tt][Rr][Uu][Ss][Tt][Ee][Dd]|[Uu][Nn][Ii][Qq][Uu][Ee]|[Uu][Nn][Ll][Oo][Cc][Kk]|[Uu][Ss][Ee]|[Uu][Ss][Ii][Nn][Gg]|[Uu][Pp][Dd][Aa][Tt][Ee]|[Vv][Aa][Ll][Uu][Ee][Ss]|[Vv][Aa][Rr][Ii][Aa][Bb][Ll][Ee][Ss]|[Vv][Ii][Ee][Ww]|[Ww][Ii][Tt][Hh]|[Ww][Rr][Ii][Tt][Ee]|[Ww][Hh][Ee][Rr][Ee]|[Zz][Ee][Rr][Oo][Ff][Ii][Ll][Ll]|[Tt][Yy][Pp][Ee]|[Xx][Oo][Rr])\b/g,
      'style': 'sh_keyword'
    },
    {
      'next': 1,
      'regex': /"/g,
      'style': 'sh_string'
    },
    {
      'next': 2,
      'regex': /'/g,
      'style': 'sh_string'
    },
    {
      'next': 3,
      'regex': /`/g,
      'style': 'sh_string'
    },
    {
      'next': 4,
      'regex': /#/g,
      'style': 'sh_comment'
    },
    {
      'next': 5,
      'regex': /\/\/\//g,
      'style': 'sh_comment'
    },
    {
      'next': 11,
      'regex': /\/\//g,
      'style': 'sh_comment'
    },
    {
      'next': 12,
      'regex': /\/\*\*/g,
      'style': 'sh_comment'
    },
    {
      'next': 18,
      'regex': /\/\*/g,
      'style': 'sh_comment'
    },
    {
      'next': 19,
      'regex': /--/g,
      'style': 'sh_comment'
    },
    {
      'regex': /~|!|%|\^|\*|\(|\)|-|\+|=|\[|\]|\\|:|;|,|\.|\/|\?|&|<|>|\|/g,
      'style': 'sh_symbol'
    },
    {
      'regex': /\b[+-]?(?:(?:0x[A-Fa-f0-9]+)|(?:(?:[\d]*\.)?[\d]+(?:[eE][+-]?[\d]+)?))u?(?:(?:int(?:8|16|32|64))|L)?\b/g,
      'style': 'sh_number'
    }
  ],
  [
    {
      'exit': true,
      'regex': /"/g,
      'style': 'sh_string'
    },
    {
      'regex': /\\./g,
      'style': 'sh_specialchar'
    }
  ],
  [
    {
      'exit': true,
      'regex': /'/g,
      'style': 'sh_string'
    },
    {
      'regex': /\\./g,
      'style': 'sh_specialchar'
    }
  ],
  [
    {
      'exit': true,
      'regex': /`/g,
      'style': 'sh_string'
    },
    {
      'regex': /\\./g,
      'style': 'sh_specialchar'
    }
  ],
  [
    {
      'exit': true,
      'regex': /$/g
    }
  ],
  [
    {
      'exit': true,
      'regex': /$/g
    },
    {
      'regex': /(?:<?)[A-Za-z0-9_\.\/\-_]+@[A-Za-z0-9_\.\/\-_]+(?:>?)/g,
      'style': 'sh_url'
    },
    {
      'regex': /(?:<?)[A-Za-z0-9_]+:\/\/[A-Za-z0-9_\.\/\-_]+(?:>?)/g,
      'style': 'sh_url'
    },
    {
      'next': 6,
      'regex': /<!DOCTYPE/g,
      'state': 1,
      'style': 'sh_preproc'
    },
    {
      'next': 8,
      'regex': /<!--/g,
      'style': 'sh_comment'
    },
    {
      'regex': /<(?:\/)?[A-Za-z][A-Za-z0-9]*(?:\/)?>/g,
      'style': 'sh_keyword'
    },
    {
      'next': 9,
      'regex': /<(?:\/)?[A-Za-z][A-Za-z0-9]*/g,
      'state': 1,
      'style': 'sh_keyword'
    },
    {
      'regex': /&(?:[A-Za-z0-9]+);/g,
      'style': 'sh_preproc'
    },
    {
      'regex': /@[A-Za-z]+/g,
      'style': 'sh_type'
    },
    {
      'regex': /(?:TODO|FIXME)(?:[:]?)/g,
      'style': 'sh_todo'
    }
  ],
  [
    {
      'exit': true,
      'regex': />/g,
      'style': 'sh_preproc'
    },
    {
      'next': 7,
      'regex': /"/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'regex': /\\(?:\\|")/g
    },
    {
      'exit': true,
      'regex': /"/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'exit': true,
      'regex': /-->/g,
      'style': 'sh_comment'
    },
    {
      'next': 8,
      'regex': /<!--/g,
      'style': 'sh_comment'
    }
  ],
  [
    {
      'exit': true,
      'regex': /(?:\/)?>/g,
      'style': 'sh_keyword'
    },
    {
      'regex': /[^=" \t>]+/g,
      'style': 'sh_type'
    },
    {
      'regex': /=/g,
      'style': 'sh_symbol'
    },
    {
      'next': 10,
      'regex': /"/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'regex': /\\(?:\\|")/g
    },
    {
      'exit': true,
      'regex': /"/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'exit': true,
      'regex': /$/g
    }
  ],
  [
    {
      'exit': true,
      'regex': /\*\//g,
      'style': 'sh_comment'
    },
    {
      'next': 12,
      'regex': /\/\*\*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /(?:<?)[A-Za-z0-9_\.\/\-_]+@[A-Za-z0-9_\.\/\-_]+(?:>?)/g,
      'style': 'sh_url'
    },
    {
      'regex': /(?:<?)[A-Za-z0-9_]+:\/\/[A-Za-z0-9_\.\/\-_]+(?:>?)/g,
      'style': 'sh_url'
    },
    {
      'next': 13,
      'regex': /<!DOCTYPE/g,
      'state': 1,
      'style': 'sh_preproc'
    },
    {
      'next': 15,
      'regex': /<!--/g,
      'style': 'sh_comment'
    },
    {
      'regex': /<(?:\/)?[A-Za-z][A-Za-z0-9]*(?:\/)?>/g,
      'style': 'sh_keyword'
    },
    {
      'next': 16,
      'regex': /<(?:\/)?[A-Za-z][A-Za-z0-9]*/g,
      'state': 1,
      'style': 'sh_keyword'
    },
    {
      'regex': /&(?:[A-Za-z0-9]+);/g,
      'style': 'sh_preproc'
    },
    {
      'regex': /@[A-Za-z]+/g,
      'style': 'sh_type'
    },
    {
      'regex': /(?:TODO|FIXME)(?:[:]?)/g,
      'style': 'sh_todo'
    }
  ],
  [
    {
      'exit': true,
      'regex': />/g,
      'style': 'sh_preproc'
    },
    {
      'next': 14,
      'regex': /"/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'regex': /\\(?:\\|")/g
    },
    {
      'exit': true,
      'regex': /"/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'exit': true,
      'regex': /-->/g,
      'style': 'sh_comment'
    },
    {
      'next': 15,
      'regex': /<!--/g,
      'style': 'sh_comment'
    }
  ],
  [
    {
      'exit': true,
      'regex': /(?:\/)?>/g,
      'style': 'sh_keyword'
    },
    {
      'regex': /[^=" \t>]+/g,
      'style': 'sh_type'
    },
    {
      'regex': /=/g,
      'style': 'sh_symbol'
    },
    {
      'next': 17,
      'regex': /"/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'regex': /\\(?:\\|")/g
    },
    {
      'exit': true,
      'regex': /"/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'exit': true,
      'regex': /\*\//g,
      'style': 'sh_comment'
    },
    {
      'next': 18,
      'regex': /\/\*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /(?:<?)[A-Za-z0-9_\.\/\-_]+@[A-Za-z0-9_\.\/\-_]+(?:>?)/g,
      'style': 'sh_url'
    },
    {
      'regex': /(?:<?)[A-Za-z0-9_]+:\/\/[A-Za-z0-9_\.\/\-_]+(?:>?)/g,
      'style': 'sh_url'
    },
    {
      'regex': /(?:TODO|FIXME)(?:[:]?)/g,
      'style': 'sh_todo'
    }
  ],
  [
    {
      'exit': true,
      'regex': /$/g
    }
  ]
];
