import matplotlib.pyplot as plt
import matplotlib.patches as patches

# Initialize the figure and axis
fig, ax = plt.subplots()


# Function to draw arrow
def draw_arrow(ax, start, end):
    ax.annotate(
        "", xy=end, xytext=start, arrowprops=dict(arrowstyle="->", lw=1.5), fontsize=12
    )


# Draw CPU outline
cpu_rect = patches.Rectangle(
    (0, 0), 200, 200, linewidth=1, edgecolor="black", facecolor="none"
)
ax.add_patch(cpu_rect)
plt.text(90, 190, "CPU", fontsize=12)

# Draw Registers
for i in range(16):
    register_rect = patches.Rectangle(
        (10, 180 - i * 5), 20, 4, linewidth=1, edgecolor="black", facecolor="none"
    )
    ax.add_patch(register_rect)
    plt.text(35, 180 - i * 5, f"R{i}", fontsize=8)

# Draw ALU
alu_rect = patches.Rectangle(
    (50, 160), 30, 20, linewidth=1, edgecolor="black", facecolor="none"
)
ax.add_patch(alu_rect)
plt.text(55, 165, "ALU", fontsize=8)
draw_arrow(ax, (40, 165), (50, 165))  # Arrow from Registers to ALU

# Draw Decoder
decoder_rect = patches.Rectangle(
    (50, 140), 30, 15, linewidth=1, edgecolor="black", facecolor="none"
)
ax.add_patch(decoder_rect)
plt.text(55, 145, "Decoder", fontsize=8)

# Draw IR, MDR, Temp1, Temp2, MAR
for i, label in enumerate(["IR", "MDR", "Temp1", "Temp2", "MAR"]):
    rect = patches.Rectangle(
        (100, 180 - i * 10), 20, 8, linewidth=1, edgecolor="black", facecolor="none"
    )
    ax.add_patch(rect)
    plt.text(125, 180 - i * 10, label, fontsize=8)

# Draw Data Bus
data_bus_rect = patches.Rectangle(
    (0, 60), 200, 5, linewidth=1, edgecolor="black", facecolor="none"
)
ax.add_patch(data_bus_rect)
plt.text(90, 61, "16-bit Data Bus", fontsize=8)

# Draw Address Bus
address_bus_rect = patches.Rectangle(
    (0, 50), 200, 5, linewidth=1, edgecolor="black", facecolor="none"
)
ax.add_patch(address_bus_rect)
plt.text(85, 51, "16-bit Address Bus", fontsize=8)

# Draw Memory
memory_rect = patches.Rectangle(
    (210, 0), 50, 200, linewidth=1, edgecolor="black", facecolor="none"
)
ax.add_patch(memory_rect)
plt.text(220, 190, "Memory", fontsize=12)
plt.text(225, 180, "64 KB", fontsize=8)

# Draw interface lines and arrows
draw_arrow(ax, (200, 63), (210, 63))  # Data bus to memory
draw_arrow(ax, (200, 53), (210, 53))  # Address bus to memory

# Set axis limits and aspect ratio
ax.set_xlim(0, 260)
ax.set_ylim(0, 200)
ax.set_aspect("equal", "box")

# Hide axis
ax.axis("off")

plt.show()
