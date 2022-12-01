package day1

import "testing"

func Test_MaxCalories(t *testing.T) {
	type args struct {
		filename string
	}
	tests := []struct {
		name    string
		args    args
		wantMax int
		wantErr bool
	}{
		{"empty", args{}, 0, true},
		{"example", args{filename: "test_input.txt"}, 24000, false},
		{"input", args{filename: "input.txt"}, 68467, false},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			gotMax, err := MaxCalories(tt.args.filename)
			if (err != nil) != tt.wantErr {
				t.Errorf("maxCalories() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if gotMax != tt.wantMax {
				t.Errorf("maxCalories() = %v, want %v", gotMax, tt.wantMax)
			}
		})
	}
}
