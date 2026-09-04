// Marp CLI configuration (auto-loaded from this directory by `marp`).
//
// Obsidian callouts as slide boxes. The deck's definition boxes and callouts
// are written in Obsidian's callout syntax,
//
//     > [!definition] **Definition 1.1.1.**
//     > A category consists of ...
//
// so that Obsidian renders their markdown and mathematics in both editing
// views. This engine turns each such blockquote into the <div> the theme
// styles, `<div class="defbox">` or `<div class="callout">`, and folds the
// title into the first paragraph, so the rendered slides are unchanged.
//
// Type mapping: callout, callout-sm, note, info -> class "callout" (and "sm");
// every other type (definition, lemma, proposition, claim, exercise,
// notation, ...) -> class "defbox".

const CALLOUT_CLASSES = {
  callout: 'callout',
  'callout-sm': 'callout sm',
  note: 'callout',
  info: 'callout',
};

function obsidianCallouts(md) {
  md.core.ruler.after('block', 'obsidian_callouts', (state) => {
    const tokens = state.tokens;
    for (let i = 0; i < tokens.length; i++) {
      if (tokens[i].type !== 'blockquote_open') continue;
      const pOpen = tokens[i + 1];
      const inline = tokens[i + 2];
      if (!pOpen || pOpen.type !== 'paragraph_open') continue;
      if (!inline || inline.type !== 'inline') continue;
      const m = /^\[!([A-Za-z][\w-]*)\]([+-]?)[ \t]*([^\n]*)(?:\n|$)/.exec(inline.content);
      if (!m) continue;

      const type = m[1].toLowerCase();
      const title = m[3].trim();
      const rest = inline.content.slice(m[0].length);
      const cls = CALLOUT_CLASSES[type] || 'defbox';

      let depth = 0;
      let j = i;
      for (; j < tokens.length; j++) {
        if (tokens[j].type === 'blockquote_open') depth += 1;
        else if (tokens[j].type === 'blockquote_close') {
          depth -= 1;
          if (depth === 0) break;
        }
      }
      tokens[i].tag = 'div';
      tokens[i].attrSet('class', cls);
      tokens[j].tag = 'div';

      const merged = title ? (rest ? `${title} ${rest}` : title) : rest;
      if (merged) {
        inline.content = merged;
      } else {
        tokens.splice(i + 1, 3);
      }
    }
  });
}

module.exports = {
  engine: ({ marp }) => marp.use(obsidianCallouts),
};
