import Component from "@glimmer/component";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";

export default class HeaderDropdownLinks extends Component {
  @service site;

  get headerLinks() {
    return settings.header_links;
  }

  <template>
    <div class="header-links">
      <div class="wrap">
        <ul class="header-links__items">
          {{#each this.headerLinks as |headerLink|}}
            <li class="header-links__item">
              <a
                href={{unless headerLink.dropdown_links.length headerLink.url}}
              >
                <span>
                  {{headerLink.title}}
                </span>
                {{#if headerLink.dropdown_links.length}}
                  {{icon "angle-down"}}
                {{/if}}
              </a>
              {{#if headerLink.dropdown_links.length}}
                <ul class="header-links__item-dropdown">
                  {{#each headerLink.dropdown_links as |dropdownLink|}}
                    <li>
                      <a href={{dropdownLink.url}}>
                        <span>
                          {{dropdownLink.title}}
                        </span>
                        {{#if dropdownLink.description}}
                          <span>
                            {{dropdownLink.description}}
                          </span>
                        {{/if}}
                      </a>
                    </li>
                  {{/each}}
                </ul>
              {{/if}}
            </li>
          {{/each}}
        </ul>
      </div>
    </div>
  </template>
}
