if (! this.sh_languages) {
  this.sh_languages = {};
}
sh_languages['perl'] = [
  [
    {
      'regex': /\b(?:import)\b/g,
      'style': 'sh_preproc'
    },
    {
      'regex': /s\{(?:\\\}|[^}])*\}\{(?:\\\}|[^}])*\}[ixsmogce]*/g,
      'style': 'sh_regexp'
    },
    {
      'regex': /s\((?:\\\)|[^)])*\)\((?:\\\)|[^)])*\)[ixsmogce]*/g,
      'style': 'sh_regexp'
    },
    {
      'regex': /s\[(?:\\\]|[^\]])*\]\[(?:\\\]|[^\]])*\][ixsmogce]*/g,
      'style': 'sh_regexp'
    },
    {
      'regex': /s<.*><.*>[ixsmogce]*/g,
      'style': 'sh_regexp'
    },
    {
      'regex': /s([^A-Za-z0-9 \t]).*\1.*\1[ixsmogce]*(?=[ \t]*(\)|;))/g,
      'style': 'sh_regexp'
    },
    {
      'regex': /s([^A-Za-z0-9 \t]).*\1[ \t]*([^A-Za-z0-9 \t]).*\2[ixsmogce]*(?=[ \t]*(\)|;))/g,
      'style': 'sh_regexp'
    },
    {
      'next': 1,
      'regex': /#/g,
      'style': 'sh_comment'
    },
    {
      'regex': /\b[+-]?(?:(?:0x[A-Fa-f0-9]+)|(?:(?:[\d]*\.)?[\d]+(?:[eE][+-]?[\d]+)?))u?(?:(?:int(?:8|16|32|64))|L)?\b/g,
      'style': 'sh_number'
    },
    {
      'next': 2,
      'regex': /(?:m|qr)(?=\{)/g,
      'style': 'sh_keyword'
    },
    {
      'next': 4,
      'regex': /(?:m|qr)(?=#)/g,
      'style': 'sh_keyword'
    },
    {
      'next': 6,
      'regex': /(?:m|qr)(?=\|)/g,
      'style': 'sh_keyword'
    },
    {
      'next': 8,
      'regex': /(?:m|qr)(?=@)/g,
      'style': 'sh_keyword'
    },
    {
      'next': 10,
      'regex': /(?:m|qr)(?=<)/g,
      'style': 'sh_keyword'
    },
    {
      'next': 12,
      'regex': /(?:m|qr)(?=\[)/g,
      'style': 'sh_keyword'
    },
    {
      'next': 14,
      'regex': /(?:m|qr)(?=\\)/g,
      'style': 'sh_keyword'
    },
    {
      'next': 16,
      'regex': /(?:m|qr)(?=\/)/g,
      'style': 'sh_keyword'
    },
    {
      'next': 18,
      'regex': /"/g,
      'style': 'sh_string'
    },
    {
      'next': 19,
      'regex': /'/g,
      'style': 'sh_string'
    },
    {
      'next': 20,
      'regex': /</g,
      'style': 'sh_string'
    },
    {
      'regex': /[A-Za-z0-9_]*\/[^\n]*\/[A-Za-z0-9_]*/g,
      'style': 'sh_string'
    },
    {
      'regex': /\b(?:chomp|chop|chr|crypt|hex|i|index|lc|lcfirst|length|oct|ord|pack|q|qq|reverse|rindex|sprintf|substr|tr|uc|ucfirst|m|s|g|qw|abs|atan2|cos|exp|hex|int|log|oct|rand|sin|sqrt|srand|my|local|our|delete|each|exists|keys|values|pack|read|syscall|sysread|syswrite|unpack|vec|undef|unless|return|length|grep|sort|caller|continue|dump|eval|exit|goto|last|next|redo|sub|wantarray|pop|push|shift|splice|unshift|split|switch|join|defined|foreach|last|chop|chomp|bless|dbmclose|dbmopen|ref|tie|tied|untie|while|next|map|eq|die|cmp|lc|uc|and|do|if|else|elsif|for|use|require|package|import|chdir|chmod|chown|chroot|fcntl|glob|ioctl|link|lstat|mkdir|open|opendir|readlink|rename|rmdir|stat|symlink|umask|unlink|utime|binmode|close|closedir|dbmclose|dbmopen|die|eof|fileno|flock|format|getc|print|printf|read|readdir|rewinddir|seek|seekdir|select|syscall|sysread|sysseek|syswrite|tell|telldir|truncate|warn|write|alarm|exec|fork|getpgrp|getppid|getpriority|kill|pipe|qx|setpgrp|setpriority|sleep|system|times|x|wait|waitpid)\b/g,
      'style': 'sh_keyword'
    },
    {
      'next': 21,
      'regex': /^\=(?:head1|head2|item)/g,
      'style': 'sh_comment'
    },
    {
      'regex': /(?:\$[#]?|@|%)[\/A-Za-z0-9_]+/g,
      'style': 'sh_variable'
    },
    {
      'regex': /~|!|%|\^|\*|\(|\)|-|\+|=|\[|\]|\\|:|;|,|\.|\/|\?|&|<|>|\|/g,
      'style': 'sh_symbol'
    },
    {
      'regex': /\{|\}/g,
      'style': 'sh_cbracket'
    },
    {
      'regex': /(?:[A-Za-z]|_)[A-Za-z0-9_]*[ \t]*(?=\()/g,
      'style': 'sh_function'
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
      'next': 3,
      'regex': /\{/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'regex': /[ \t]+#.*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /\$(?:[A-Za-z0-9_]+|\{[A-Za-z0-9_]+\})/g,
      'style': 'sh_variable'
    },
    {
      'regex': /\\\{|\\\}/g,
      'style': 'sh_regexp'
    },
    {
      'exitall': true,
      'regex': /\}/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'next': 5,
      'regex': /#/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'regex': /[ \t]+#.*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /\$(?:[A-Za-z0-9_]+|\{[A-Za-z0-9_]+\})/g,
      'style': 'sh_variable'
    },
    {
      'regex': /\\#/g,
      'style': 'sh_regexp'
    },
    {
      'exitall': true,
      'regex': /#/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'next': 7,
      'regex': /\|/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'regex': /[ \t]+#.*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /\$(?:[A-Za-z0-9_]+|\{[A-Za-z0-9_]+\})/g,
      'style': 'sh_variable'
    },
    {
      'regex': /\\\|/g,
      'style': 'sh_regexp'
    },
    {
      'exitall': true,
      'regex': /\|/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'next': 9,
      'regex': /@/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'regex': /[ \t]+#.*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /\$(?:[A-Za-z0-9_]+|\{[A-Za-z0-9_]+\})/g,
      'style': 'sh_variable'
    },
    {
      'regex': /\\@/g,
      'style': 'sh_regexp'
    },
    {
      'exitall': true,
      'regex': /@/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'next': 11,
      'regex': /</g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'regex': /[ \t]+#.*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /\$(?:[A-Za-z0-9_]+|\{[A-Za-z0-9_]+\})/g,
      'style': 'sh_variable'
    },
    {
      'regex': /\\<|\\>/g,
      'style': 'sh_regexp'
    },
    {
      'exitall': true,
      'regex': />/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'next': 13,
      'regex': /\[/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'regex': /[ \t]+#.*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /\$(?:[A-Za-z0-9_]+|\{[A-Za-z0-9_]+\})/g,
      'style': 'sh_variable'
    },
    {
      'regex': /\\]/g,
      'style': 'sh_regexp'
    },
    {
      'exitall': true,
      'regex': /\]/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'next': 15,
      'regex': /\\/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'regex': /[ \t]+#.*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /\$(?:[A-Za-z0-9_]+|\{[A-Za-z0-9_]+\})/g,
      'style': 'sh_variable'
    },
    {
      'regex': /\\\\/g,
      'style': 'sh_regexp'
    },
    {
      'exitall': true,
      'regex': /\\/g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'next': 17,
      'regex': /\//g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'regex': /[ \t]+#.*/g,
      'style': 'sh_comment'
    },
    {
      'regex': /\$(?:[A-Za-z0-9_]+|\{[A-Za-z0-9_]+\})/g,
      'style': 'sh_variable'
    },
    {
      'regex': /\\\//g,
      'style': 'sh_regexp'
    },
    {
      'exitall': true,
      'regex': /\//g,
      'style': 'sh_regexp'
    }
  ],
  [
    {
      'exit': true,
      'regex': /$/g
    },
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
    },
    {
      'regex': /\\(?:\\|')/g
    },
    {
      'exit': true,
      'regex': /'/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'exit': true,
      'regex': /$/g
    },
    {
      'exit': true,
      'regex': />/g,
      'style': 'sh_string'
    }
  ],
  [
    {
      'exit': true,
      'regex': /\=cut/g,
      'style': 'sh_comment'
    }
  ]
];
