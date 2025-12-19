import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SuggestedFriendItem } from './suggested-friend-item';

describe('SuggestedFriendItem', () => {
  let component: SuggestedFriendItem;
  let fixture: ComponentFixture<SuggestedFriendItem>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SuggestedFriendItem]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SuggestedFriendItem);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
