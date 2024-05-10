import EmberObject, { computed } from '@ember/object';
import { A } from '@ember/array';
import Component from '@ember/component';
import { inject as service } from '@ember/service';
import { capitalize } from '@ember/string'; // ember 4

export default Component.extend({
  tagName: '',
  optionDetails: null,
  optionString: null,
  selectOption: false,
  flashMessages: service(),
  gameApi: service(),
  
  didInsertElement: function() {
    this._super(...arguments);
    let self = this;
    this.set('updateCallback', function() { return self.onUpdate(); } );
    this.set('optionString', this.opList.mapBy('name')[0]); // initialize value
   },
 
  optionPoints: computed('charList.@each.rating', function() {
    return this.countPointsInGroup(this.get('charList'));
  }),

   countPointsInGroup: function(list) {
     if (!list) {
       return 0;
     }
     let total = 0;
     list.forEach(function (ability) {
       total = total + ability.rating;
     });
     return total;
   },

   optionDesc: computed('optionString',function() {
     let list = this.opList;
     let item = list.findBy('name', this.optionString);
     if (item) {
       return item.desc;
     } else {
       return null;
    }
   }),

   optionMin: computed('optionString',function() {
     let list = this.opList;
     let item = list.findBy('name', this.optionString);
     if (item) {
       return item.ranks[0];
     } else {
       return null;
    }
   }),

   typePlural: computed('type',function() {
     return capitalize(this.type) + "s"; 
   }),

   typeCapitalize: computed('type',function() {
     return capitalize(this.type); 
   }),

  validateChar: function() {
// lots of stuff to be added here later!
    this.set('charErrors', A());

  },

  actions: {

    abilityChanged() {
      this.validateChar();
    },

    addOption() {
      let option_list = this.opList.mapBy('name');
      let optionString = this.optionString || option_list[0];
      let optionDetails = this.optionDetails || null;
      let optionMin = 1;
      if (!optionString) {
        this.flashMessages.danger("You have to specify a valid " + this.type + ".");
        this.set('selectOption', false);
        return;
      }
      optionMin = this.optionMin;
      if (!optionDetails) {
         this.flashMessages.danger("You have to specify details for the " + this.type + ".");
         this.set('selectOption', false);
         return;
      }
      this.set('optionDetails', null);
      this.set('selectOption', false);
      this.get('charList').pushObject( EmberObject.create( { name: optionString, rating: optionMin, details: optionDetails }) );
      this.validateChar();
    }

  }
    
});
