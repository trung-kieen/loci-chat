import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BlockUserList } from './block-user-list';

describe('BlockUserList', () => {
  let component: BlockUserList;
  let fixture: ComponentFixture<BlockUserList>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BlockUserList]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BlockUserList);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
