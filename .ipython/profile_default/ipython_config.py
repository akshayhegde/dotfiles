# Configuration file for ipython.

from pygments.token import Token, String, Number, Keyword, Name, Comment

c = get_config()

c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.term_title = False
c.TerminalInteractiveShell.true_color = True
c.TerminalInteractiveShell.highlighting_style = 'bw'
c.TerminalInteractiveShell.editing_mode = 'vi'


c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Prompt: '#B3B8C4',
    Token.PromptNum: '#B3B8C4',
    Token.OutPrompt: '#B3B8C4',
    Token.OutPromptNum: '#B3B8C4',

    String: '#95B47B noitalic',

    Keyword: '#A57A9E',

    Name.Function: '#CC6666',
    Name.Builtin:'#CC6666',
    Name.Class: '#CC6666 nobold',
    Name.Decorator: '#CC6666 italic',

    Comment: '#515F6A',
}
