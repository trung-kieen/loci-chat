import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GroupProfile } from './group-profile';

describe('GroupProfile', () => {
  let component: GroupProfile;
  let fixture: ComponentFixture<GroupProfile>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GroupProfile]
    })
    .compileComponents();

    fixture = TestBed.createComponent(GroupProfile);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
