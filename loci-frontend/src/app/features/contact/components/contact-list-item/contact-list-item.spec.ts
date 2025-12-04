import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ContactListItem } from './contact-list-item';

describe('ContactListItem', () => {
  let component: ContactListItem;
  let fixture: ComponentFixture<ContactListItem>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ContactListItem]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ContactListItem);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
