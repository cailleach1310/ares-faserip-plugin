import EmberObject, { computed } from '@ember/object';
import { A } from '@ember/array';
import Component from '@ember/component';
import { inject as service } from '@ember/service';
import { capitalize } from '@ember/string'; // ember 4

export default Component.extend({
  tagName: '',
  skillString: null,
  selectSkill: false,
  flashMessages: service(),
  gameApi: service(),
  
  didInsertElement: function() {
    this._super(...arguments);
    let self = this;
    this.set('updateCallback', function() { return self.onUpdate(); } );
    this.set('skillString', this.skillList[0].name); // initialize value
   },
 
  skillPoints: computed('skillList.@each.rating', function() {
    return this.countPointsInGroup(this.get('skillList'));
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

   skillDesc: computed('skillString',function() {
     let list = this.skillList;
     let item = list.findBy('name', this.skillString);
     if (item) {
       return item.desc;
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
      this.set('rank', val);
    },

    addSkill() {
      let skillList = this.skillList.mapBy('name');
      let skillString = this.skillString || skillList[0];
      let skillMin = 1; //this.skillRanks[0];
      if (!skillString) {
        this.flashMessages.danger("You have to specify a valid skill.");
        this.set('selectSkill', false);
        return;
      }
      this.set('selectSkill', false);
      this.get('skillList').pushObject( EmberObject.create( { name: skillString, rank: skillMin }) );
      this.validateChar();
    }

  }
    
});
