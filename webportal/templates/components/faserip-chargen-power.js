import EmberObject, { computed } from '@ember/object';
import { A } from '@ember/array';
import Component from '@ember/component';
import { inject as service } from '@ember/service';
import { capitalize } from '@ember/string'; // ember 4

export default Component.extend({
  tagName: '',
  powerNotes: null,
  powerString: null,
  powerRank: null,
  selectPower: false,
  flashMessages: service(),
  gameApi: service(),
  
  didInsertElement: function() {
    this._super(...arguments);
    let self = this;
    let defaultRank = this.powerRanks[0];
    this.set('updateCallback', function() { return self.onUpdate(); } );
    this.set('powerString', this.opList.mapBy('name')[0]); // initialize value
    this.set('powerRank', defaultRank);
   },
 
  powerPoints: computed('charList.@each.rank', function() {
    return this.countPointsInGroup(this.get('charList'));
  }),

   countPointsInGroup: function(list) {
     if (!list) {
       return 0;
     }
     let total = 0;
     list.forEach(function (ability) {
       total = total + ability.rank;
     });
     return total;
   },

   selectedRank: computed('powerRank',function() {
      let list = this.get('powerRanks');
      return list.findBy('value', this.rank);
   }),

   powerDesc: computed('powerString',function() {
     let list = this.opList;
     let item = list.findBy('name', this.powerString);
     if (item) {
       return item.desc;
     } else {
       return null;
    }
   }),

   powerMin: computed('powerString',function() {
     let list = this.opList;
     let item = list.findBy('name', this.powerString);
     if (item) {
       return item.ranks[0];
     } else {
       return null;
    }
   }),

  validateChar: function() {
// lots of stuff to be added here later!
    this.set('charErrors', A());

  },

  actions: {

    abilityChanged() {
      this.validateChar();
    },

    rankChanged(val) {
      this.set('powerRank', val.value);
    },

    addPower() {
      let power_list = this.opList.mapBy('name');
      let powerString = this.powerString || power_list[0];
      let powerRank = this.powerRank || this.powerRanks[0].value;
      let powerNotes = this.powerNotes || null;
      let powerMin = 1;
      if (!powerString) {
        this.flashMessages.danger("You have to specify a valid " + this.type + ".");
        this.set('selectPower', false);
        return;
      }
      powerMin = this.powerMin;
      if (!powerNotes) {
         this.flashMessages.danger("You have to specify notes for the " + this.type + ".");
         this.set('selectPower', false);
         return;
      }
      this.set('powerNotes', null);
      this.set('selectPower', false);
      this.get('charList').pushObject( EmberObject.create( { name: powerString, rank: powerRank, notes: powerNotes }) );
      this.validateChar();
    }

  }
    
});
