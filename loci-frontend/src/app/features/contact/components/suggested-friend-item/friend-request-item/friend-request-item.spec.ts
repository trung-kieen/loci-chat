import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FriendRequestItem } from './friend-request-item';

describe('FriendRequestItem', () => {
  let component: FriendRequestItem;
  let fixture: ComponentFixture<FriendRequestItem>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FriendRequestItem]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FriendRequestItem);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
