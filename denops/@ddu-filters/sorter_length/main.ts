import type { DduItem } from "jsr:@shougo/ddu-vim@~11.3.0/types";
import { BaseFilter } from "jsr:@shougo/ddu-vim@~11.3.0/filter";

type Params = Record<string, never>;

// Shortest items first. Used before sorter_fzf, which sorts by score with a
// stable sort, so equally scored matches stay shortest first, like fzf's
// default --tiebreak=length.
export class Filter extends BaseFilter<Params> {
  override filter(args: { items: DduItem[] }): Promise<DduItem[]> {
    const length = (item: DduItem) => (item.matcherKey || item.word).length;
    return Promise.resolve(args.items.sort((a, b) => length(a) - length(b)));
  }

  override params(): Params {
    return {};
  }
}
