import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ChatLayout } from './chat-layout';

describe('ChatLayout', () => {
  let component: ChatLayout;
  let fixture: ComponentFixture<ChatLayout>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ChatLayout]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ChatLayout);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
