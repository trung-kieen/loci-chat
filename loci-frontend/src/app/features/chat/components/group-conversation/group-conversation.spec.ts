import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GroupConversation } from './group-conversation';

describe('GroupConversation', () => {
  let component: GroupConversation;
  let fixture: ComponentFixture<GroupConversation>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GroupConversation]
    })
    .compileComponents();

    fixture = TestBed.createComponent(GroupConversation);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
