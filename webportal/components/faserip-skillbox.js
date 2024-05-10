import EmberObject, { computed } from '@ember/object';
import { A } from '@ember/array';
import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  tagName: '',
  flashMessages: service(),
  gameApi: service(),
  
  didInsertElement: function() {
    this._super(...arguments);
    let self = this;
    this.set('updateCallback', function() { return self.onUpdate(); } );
   },

  validateChar: function() {
    this.set('charErrors', A());
  },

  actions: {

    abilityChanged(val) {
      this.set('rank', val);
      this.validateChar();
    }

  }
    
});
