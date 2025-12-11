import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EmptyChat } from './empty-chat';

describe('EmptyChat', () => {
  let component: EmptyChat;
  let fixture: ComponentFixture<EmptyChat>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EmptyChat]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EmptyChat);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
