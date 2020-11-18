.MODEL FLAT, C
.CODE
MYASM PROC C
		push esi				
		push edi
		push ebp
	
		mov eax, [esp+16]		;*arr
		mov edx, [esp+20]		;*LGrInt
		mov ebx, [esp+24]		;*res

		mov si, [esp+28]		;NInt
		and esi, 0000ffffh
		mov cx, [esp+32]		;NumRanDat
		and ecx, 0000ffffh
		xor ebp, ebp			;���� ����� ��� mov ebp,0

	for1:
		push ecx				;������� �������� ������� ����� � ����
		mov cx,si				;�������� �� �������� ������� �����
		mov bp, [eax]			;����� ����� �� arr
		and ebp, 0000ffffh
		xor edi,edi				;���� ����� ��� mov edi,0

		for2:
			cmp bp, [edx+edi]	;���������� ����� � ����� �������
			jge quit			;���� ����� ������, ������ ������ � ��������
			add edi,2			;������� � ����. ��������� (����������� �������� �� ���, �.�. int - 2 �����)
		loop for2				;� �����, ���� �� ������� �� ���� ����������

	quit:						;���������� ���-�� ��������� � ��������
		push edx				;��������� edx � �����
		mov edx, [ebx+edi]		;����� ��������������� ��������� ���������� ���������
		inc edx					;����������� ��� ����� �� 1
		mov [ebx+edi],edx		;������� ��� ������� � ������ res
		pop edx					;���������� �� ����� edx
		pop ecx					;���������� �� ����� �������� ������� �����
		add eax,2				;������� � ���������� �����
	loop for1					;� ����� ���� �� ������� �� ���� ������
		
		pop ebp
		pop edi
		pop esi

		ret

MYASM ENDP
END
